# terraform-state-basics

Zenn の記事「本当にTerraformを理解している？」で使った検証コードです。クラウドは使いません。手元だけで試せます。

## 必要なもの

- Terraform 1.12.1（検証に使った版）

## ファイル

| ファイル | 中身 |
|---|---|
| [main.tf](main.tf) | `out/hello.txt` を作る `local_file` だけ |
| [add/slow.tf](add/slow.tf) | 15秒かかるリソース。ロックの章で使う |
| [secret/main.tf](secret/main.tf) | `random_password` だけ。機密の章で使う |

`main.tf` には backend を書いていません。そのため既定の local backend になり、state は同じディレクトリの `terraform.tfstate` に入ります。

## 試し方

```sh
terraform init
terraform plan
terraform apply
```

記事の実験は次のとおりです。

```sh
# state がないと、作り直そうとする
mv terraform.tfstate /tmp/ && terraform plan
mv /tmp/terraform.tfstate .

# ファイルを手で消すと、ドリフトになる
rm out/hello.txt && terraform plan

# 古い state は書き戻せない
cp terraform.tfstate state-v1.tfstate
# main.tf の content を変えて apply してから
terraform state push state-v1.tfstate
```

ロックの章では `add/slow.tf` をルートにコピーし、ターミナルを2つ開いて同時に apply します。

```sh
cp add/slow.tf .
terraform apply   # 2つのターミナルで同時に
```

機密の章は `secret/` で別に動かします。

```sh
cd secret
terraform init && terraform apply
grep '"result"' terraform.tfstate
```

`terraform.tfstate` は `.gitignore` で外しています。`secret/` の state にはパスワードが平文で入るためです。
