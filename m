From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Fri, 5 Mar 2021 14:10:20 -0800
Subject: [LTP] [PATCH] IMA: Allow only ima-buf template for key
 measurement
In-Reply-To: <YEJZIQqa1arYKwK+@pevik>
References: <20210303203254.12856-1-nramas@linux.microsoft.com>
 <YEJZIQqa1arYKwK+@pevik>
Message-ID: <33ba6274-e7ef-27de-b481-5a702136c0df@linux.microsoft.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 3/5/21 8:15 AM, Petr Vorel wrote:

Hi Petr,

A small change is needed:

In the while loop, for each line of the KEY_CHECK policy, we need to 
check if a "template" is specified, and if it is then verify if it is 
"ima-buf".

> You need to do:
> while read line; do
> 	if ! echo $line | grep -q $template; then
> 		tst_res TCONF "only $template can be specified for $func"
> 		return 1
> 	fi
> done < $TST_TMPDIR/policy.txt
> return 0

Please see the change below:

while read line; do
	if echo $line | grep -q 'template=' && ! echo $line | grep -q $template 
; then
		tst_res TCONF "only $template can be specified for $func"
		return 1
	fi
done < $TST_TMPDIR/policy.txt
return 0

With check_policy_template() moved from ima_setup.sh to ima_keys.sh, the 
test works fine

When the policy contains the following
    measure func=KEY_CHECK keyrings=key_import_test template=ima-buf
    measure func=KEY_CHECK keyrings=.builtin_trusted_keys

the test passes:

ima_keys 1 TINFO: verify key measurement for keyrings and templates 
specified in IMA policy
ima_keys 1 TINFO: keyrings: 'key_import_test|\.builtin_trusted_keys'
ima_keys 1 TINFO: templates: 'ima-buf'
ima_keys 1 TPASS: specified keyrings were measured correctly


But if the policy is changed to below:
    measure func=KEY_CHECK keyrings=key_import_test template=ima-buf
    measure func=KEY_CHECK keyrings=.builtin_trusted_keys template=ima-sig

the test fails as expected.

ima_keys 1 TINFO: verify key measurement for keyrings and templates 
specified in IMA policy
ima_keys 1 TCONF: only template=ima-buf can be specified for func=KEY_CHECK

I'll post the updated patch shortly.

thanks,
  -lakshmi


