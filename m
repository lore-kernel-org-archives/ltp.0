From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 27 Aug 2018 13:44:07 +0300
Subject: [LTP] [PATCH v2 1/4] lib/tst_test.c: add 'needs_drivers' option
 with tst_check_drivers cmd
In-Reply-To: <20180822154137.GA18305@dell5510>
References: <1534764229-26993-1-git-send-email-alexey.kodanev@oracle.com>
 <20180822154137.GA18305@dell5510>
Message-ID: <b4197caf-47c2-751e-a29e-88811e97410b@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 08/22/2018 06:41 PM, Petr Vorel wrote:
> Hi Alexey,
> 
>> The drivers are checked with modprobe. If modprobe is not available
>> on the system, the checks are silently skipped.
> 
>> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 

Hi Petr,

>> ---
>> v2: * moved tst_check_driver() from tst_test.h to tst_kernel.h
>>     * added the new option description to the doc and comment to tst_kernel.h
>>     * iterating over the driver list moved out from tst_check_drivers(), the
>>       function renamed accordingly.
> 
> ...
>> +2.2.26 Checking kernel for the driver support
>> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> +
>> + Someties test needs certain drivers to be available in the kernel and must
> Typo Sometimes
> 
>> +end with TCONF if any are missing. For this task there is the '.needs_drivers'
>> +option which accepts NULL-terminated array of the drivers names.
>> +
>> +Since it relies on modprobe command, the check will be skipped if the command
>> +itself is not available on the system.
> 
> 
>> +++ b/testcases/lib/tst_check_drivers.c
> ...
>> +	if (argc < 2) {
>> +		fprintf(stderr, "Please provide kernel driver list\n");
>> +		return 1;
>> +	}
>> +
>> +	for (i = 1; (name = argv[i]); ++i)
>> +		if (tst_check_driver(name)) {
>> +			fprintf(stderr, "%s", name);
>> +			return 1;
>> +		}
>> +
>> +	return 0;
>> +}
> It'd be handy to be able to load module with parameters. E.g.:
> tcrypt sec=1 mode=200
> 
Do you want to start tcrypt module in the test setup? It's probably
better to add the -n/--dry-run option, so at first we verify that
the kernel actually has it, then either end with TCONF or continue.
That's the purpose of the 'needs_drivers'.

Moreover, if the failure occurs during the loading instead, the test
must return TBROK, not TCONF, right?

> We have 2 options: to name strig by spaces to b:
> ./tst_check_drivers "tcrypt sec=1 mode=200" other_module
> 
> Or handle in tst_check_drivers.c just one module and call it several times.

like modprobe?

> 
> None of them is elegant.
> 
> Otherwise LGTM.
> 
> 
> Kind regards,
> Petr
> 

