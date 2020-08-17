From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Sun, 16 Aug 2020 22:13:20 -0700
Subject: [LTP] [PATCH v2 3/4] IMA: Add a test to verify measurement of
 certificate imported into a keyring
In-Reply-To: <25a78f42d15dcb3312a59de587cb9f4e31ccd5b5.camel@linux.ibm.com>
References: <20200807204652.5928-1-pvorel@suse.cz>
 <20200807204652.5928-4-pvorel@suse.cz>
 <25a78f42d15dcb3312a59de587cb9f4e31ccd5b5.camel@linux.ibm.com>
Message-ID: <a537bbdb-1383-48f4-99a5-42ce6d082ddf@linux.microsoft.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 8/16/20 8:21 PM, Mimi Zohar wrote:

Hi Mimi,

>> +# Create a new keyring, import a certificate into it, and verify
>> +# that the certificate is measured correctly by IMA.
>> +test2()
>> +{
>> +	tst_require_cmds evmctl keyctl openssl
>> +
>> +	local cert_file="$TST_DATAROOT/x509_ima.der"
>> +	local keyring_name="key_import_test"
>> +	local temp_file="file.txt"
>> +	local keyring_id
>> +
>> +	tst_res TINFO "verify measurement of certificate imported into a keyring"
>> +
>> +	if ! check_ima_policy_content "^measure.*func=KEY_CHECK.*keyrings=.*$keyring_name"; then
>> +		tst_brk TCONF "IMA policy does not contain $keyring_name keyring"
>> +	fi
>> +
> 
> If the IMA policy contains multiple KEY_CHECK measurement policy rules
> it complains about "grep: Unmatched ( or \(".
> 
> Sample rules:
> measure func=KEY_CHECK template=ima-buf
> keyrings=.ima|.builtin_trusted_keys
> measure func=KEY_CHECK template=ima-buf keyrings=key_import_test
> 

I tried with the above policy entries, but am unable to reproduce the 
error you are seeing.

ima_keys 1 TINFO: verifying key measurement for keyrings and templates 
specified in IMA policy file
ima_keys 1 TPASS: specified keyrings were measured correctly
ima_keys 2 TPASS: logged cert matches original cert

>> +	keyctl new_session > /dev/null
>> +
>> +	keyring_id=$(keyctl newring $keyring_name @s) || \
>> +		tst_brk TBROK "unable to create a new keyring"
>> +
>> +	tst_is_num $keyring_id || \
>> +		tst_brk TBROK "unable to parse the new keyring id"
>> +
>> +	evmctl import $cert_file $keyring_id > /dev/null || \
>> +		tst_brk TBROK "unable to import a certificate into $keyring_name keyring"
> 
> "cert_file" needs to be updated from
> "ltp/testcases/kernel/security/integrity/ima/tests/datafiles/x509_ima.d
> er" to
> "ltp/testcases/kernel/security/integrity/ima/tests/../datafiles/ima_key
> s/x509_ima.der".
> 

The problem is actually due to missing "x509_ima.der" in 
"INSTALL_TARGETS" in datafiles/keys/Makefile

Adding the following line in the Makefile fixes the problem

INSTALL_TARGETS		:= x509_ima.der

  -lakshmi

> On failure to open the file,
> errno: No such file or directory (2)
> ima_keys 2 TBROK: unable to import a certificate into key_import_test keyring
> ima_keys 2 TINFO: SELinux enabled in enforcing mode, this may affect test results
> ima_keys 2 TINFO: it can be disabled with TST_DISABLE_SELINUX=1 (requires super/root)
> ima_keys 2 TINFO: install seinfo to find used SELinux profiles
> ima_keys 2 TINFO: loaded SELinux profiles: none
> 
> Mimi
> 
>> +
>> +	grep $keyring_name $ASCII_MEASUREMENTS | tail -n1 | cut -d' ' -f6 | \
>> +		xxd -r -p > $temp_file
>> +
>> +	if [ ! -s $temp_file ]; then
>> +		tst_res TFAIL "keyring $keyring_name not found in $ASCII_MEASUREMENTS"
>> +		return
>> +	fi
>> +
>> +	if ! openssl x509 -in $temp_file -inform der > /dev/null; then
>> +		tst_res TFAIL "logged certificate is not a valid x509 certificate"
>> +		return
>> +	fi
>> +
>> +	if cmp -s $temp_file $cert_file; then
>> +		tst_res TPASS "logged certificate matches the original"
>> +	else
>> +		tst_res TFAIL "logged certificate does not match original"
>> +	fi
>> +}
>> +
>>   tst_run
> 

