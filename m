From: Lachlan Sneff <t-josne@linux.microsoft.com>
Date: Tue, 16 Jun 2020 17:18:24 -0400
Subject: [LTP] [PATCH v2 2/2] IMA: Add a test to verify importing a
 certificate into keyring
In-Reply-To: <20200616155501.GB8754@dell5510>
References: <20200612143842.3993-1-t-josne@linux.microsoft.com>
 <20200612143842.3993-3-t-josne@linux.microsoft.com>
 <20200616155501.GB8754@dell5510>
Message-ID: <841954da-fbe5-4cde-5d07-f3374d512e10@linux.microsoft.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


On 6/16/20 11:55 AM, Petr Vorel wrote:
>> Add an IMA measurement test that verifies that an x509 certificate
>> can be imported into the .ima keyring and measured correctly.
>> Signed-off-by: Lachlan Sneff <t-josne@linux.microsoft.com>
>> ---
>>   .../security/integrity/ima/tests/ima_keys.sh  | 45 ++++++++++++++++++-
>>   1 file changed, 43 insertions(+), 2 deletions(-)
>> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
>> index f9c60a6fc..1eabb3e2e 100755
>> --- a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
>> +++ b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
>> @@ -5,10 +5,12 @@
>>   # Verify that keys are measured correctly based on policy.
>> -TST_NEEDS_CMDS="awk cut xxd"
>> -TST_CNT=1
>> +TST_NEEDS_CMDS="awk cut xxd keyctl evmctl openssl cmp"
>> +TST_CNT=2
>>   TST_NEEDS_DEVICE=1
>> +CERT_FILE="${CERT_FILE:-}/etc/keys/x509_ima.der"
> Key setup is something what I'd like to be either set automatically
> (ideally, but maybe too hard) or documented in
> testcases/kernel/security/integrity/ima/README.md.
>
> ima_keys 1 TINFO: verifying key measurement for keyrings and templates specified in IMA policy file
> ima_keys 1 TPASS: specified keyrings were measured correctly
> ima_keys 2 TCONF: missing /etc/keys/x509_ima.der
> => many uses will TCONF, which is not what we want.
>
> Running these scripts from examples/ in ima-evm-utils repository:
> ./ima-gen-local-ca.sh && ./ima-genkey-self.sh && ./ima-genkey.sh
>
> is obviously not enough:
>
> ima_keys 1 TINFO: verifying key measurement for keyrings and templates specified in IMA policy file
> ima_keys 1 TPASS: specified keyrings were measured correctly
> ima_keys 2 TINFO: adding a cert to the .ima keyring (/etc/keys/x509_ima.der)
> add_key failed
> errno: Required key not available (126)
> ima_keys 2 TCONF: unable to import a cert into the .ima keyring
>
> Does it make sense to copy these scripts into LTP (most distros ship them in
> development packages, but we cannot depend on it) and run them in the test
> setup? If not, we should really document that.
> + feel free to add anything relevant to README.md :)
>
> Kind regards,
> Petr

Hi Petr,

I'll look into whether it's doable to automatically generate keys. I 
suspect that including the scripts to generate the key

is the best way forward with this, as well as noting in the README how 
to generate your own key and use that instead.

Expect a further patch in the next few days.


Thank you reviewing this further!

Lachlan

