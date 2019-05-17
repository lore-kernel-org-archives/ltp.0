From: Nayna <nayna@linux.vnet.ibm.com>
Date: Fri, 17 May 2019 09:50:45 -0400
Subject: [LTP] [PATCH] ima: skip verifying TPM 2.0 PCR values
In-Reply-To: <1558041162.3971.2.camel@linux.ibm.com>
References: <1558041162.3971.2.camel@linux.ibm.com>
Message-ID: <fccc3abd-f3ce-fdb1-55d7-c18ce116446c@linux.vnet.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it



On 05/16/2019 05:12 PM, Mimi Zohar wrote:
> TPM 1.2 exported the PCRs.  Reading the TPM 2.0 PCRs requires a
> userspace application.  For now, skip this test.
>
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>   testcases/kernel/security/integrity/ima/tests/ima_tpm.sh | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh b/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
> index 0ffc3c02247d..ebe4b4c360e4 100755
> --- a/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
> @@ -88,6 +88,14 @@ test2()
>   	tst_res TINFO "verify PCR values"
>   	tst_check_cmds evmctl
>
> +	local tpm_description="/sys/class/tpm/tpm0/device/description"


I do not see a "description" file on either my PowerPC or x86 systems 
with TPM 2.0.  Perhaps instead of testing for the "description" file, if 
the "pcrs" file is not found, emit a more verbose informational message, 
for eg. - "pcrs file is not found - either you are running a TPM 2.0, or 
having sysfs failed to show pcrs for TPM 1.2"

Thanks & Regards,
       - Nayna

