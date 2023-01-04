## Step 1: VM Templates

1. Create a `secrets.json` file with the contents:

```json
{
  "proxmox_username": "packer@pve",
  "proxmox_password": "(password from 00-bootstrap terraform output --raw proxmox_packer_password)"
}
```

You can customize other packer variables there as well.

2. Run packer from the nomad directory:

`$ cd nomad`
`$ packer build -var-file=../secrets.json server.json`
`$ packer build -var-file=../secrets.json client.json`

## Notes

1. Many times, the boot wait timings need to be adjusted for different environments
2. Customize the user name/password in `nomad/http/user-data`
