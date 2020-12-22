From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Tue, 22 Dec 2020 10:37:53 -0800
Subject: [LTP] [PATCH v1 1/1] ima: Add test for selinux measurement
In-Reply-To: <X9z2+nXBdTMqHPgD@pevik>
References: <20200928194730.20862-1-nramas@linux.microsoft.com>
 <20200928194730.20862-2-nramas@linux.microsoft.com> <X9z2+nXBdTMqHPgD@pevik>
Message-ID: <0db52810-c7e2-713a-80ed-748e8bb3db74@linux.microsoft.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 12/18/20 10:37 AM, Petr Vorel wrote:

Hi Petr,

> 
> @Lakshmi
> TL;DR: I added some fixes in my fork, branch ima/selinux.v2.draft,
> https://github.com/pevik/ltp/commits/ima/selinux.v2.draft
> 
> + added 3 additional commits, one of them as you as the author.
> I moved some functions to testcases/lib/tst_security.sh, renamed them.
> Can you please have a look and test? I don't have any SELinux machine.

I'll take a look at the changes in your branch and test it with SELinux 
enabled.

> 
> @Mimi, all: any comment to this test? My changes are just LTP cleanup
> so you can comment it on this patchset.
> I suppose you get to this in January.
> 
> Some notes for my changes:
> 
> As files are quite similar (checks etc), I put both tests into single
> file ima_selinux.sh.
This should be fine.

The reason I put the tests in different files was because I couldn't 
find a way to run the tests independently (i mean - say, run the SELinux 
policy measurement test but not the state measurement test or vice-versa).

> 
>> New functionality is being added to IMA to measure data provided by
>> kernel components. With this feature, IMA policy can be set to enable
>> measuring data provided by Linux Security Modules (LSM). Currently one
>> such LSM namely selinux is being updated to use this functionality.
>> This new functionality needs test automation in LTP.
> 
>> Add test cases which verify that the IMA subsystem correctly measures
>> the data provided by selinux.
> 
> Could you please put into commit message and test kernel commit hash relevant
> for the test. Is that 8861d0af642c646c8e148ce34c294bdef6f32f6a (merged into
> v5.10-rc1) or there are more relevant commits?

The IMA hook to measure kernel critical data + SELinux measurement 
changes are still being reviewed. Tushar has posted v9 of the patch set.

> 
> ...
>> +### IMA SELinux test
>> +
>> +To enable IMA to measure SELinux state and policy, `ima_selinux_policy.sh`
>> +and `ima_selinux_state.sh` require a readable IMA policy, as well as
>> +a loaded measure policy with
>> +`measure func=CRITICAL_DATA data_sources=selinux template=ima-buf`
> I put this into
> testcases/kernel/security/integrity/ima/datafiles/ima_selinux/selinux.policy
> and mention it in docs.
Sounds good - Thanks.

"template=ima_buf" is no longer needed in the IMA policy rule since 
"ima_buf" is the default template for buffer measurement now. I will 
update "datafiles/ima_selinux/selinux.policy" file.

> 
>> +test1()
>> +{
>> +	local policy_digest expected_policy_digest algorithm
>> +	local data_source_name="selinux"
>> +	local pattern="data_sources=[^[:space:]]*$data_source_name"
>> +	local tmp_file="$TST_TMPDIR/selinux_policy_tmp_file.txt"
>> +
>> +	check_policy_pattern "$pattern" $FUNC_CRITICAL_DATA $TEMPLATE_BUF > $tmp_file || return
>> +
>> +	tst_res TINFO "Verifying selinux policy measurement"
>> +
>> +	#
>> +	# Trigger a measurement by changing selinux state
>> +	#
>> +	update_selinux_state
> Here I used tst_update_selinux_state.
okay.

> 
> ...
>> --- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> 
>> +#
>> +# Update selinux state. This is used for validating IMA
>> +# measurement of selinux constructs.
>> +#
>> +update_selinux_state()
>> +{
>> +	local cur_val new_val
>> +
>> +	cur_val=$(cat $SELINUX_FOLDER/checkreqprot)
>> +
>> +	if [ $cur_val = 1 ]; then
>> +		new_val=0
>> +	else
>> +		new_val=1
>> +	fi
>> +
>> +	echo $new_val > $SELINUX_FOLDER/checkreqprot
>> +}
>> +
>> +#
>> +# Verify selinux is enabled in the system
>> +#
>> +check_selinux_state()
>> +{
>> +	[ -d $SELINUX_FOLDER ] || tst_brk TCONF "selinux is not enabled"
>> +}
> 
> As I mentioned above, this is not needed as I put them under different names in
> testcases/lib/tst_security.sh.
okay.

> 
>>   mount_helper()
>>   {
>>   	local type="$1"
>> @@ -238,6 +265,7 @@ ima_setup()
>>   	ASCII_MEASUREMENTS="$IMA_DIR/ascii_runtime_measurements"
>>   	BINARY_MEASUREMENTS="$IMA_DIR/binary_runtime_measurements"
>>   	IMA_POLICY="$IMA_DIR/policy"
>> +	SELINUX_FOLDER="$SYSFS/fs/selinux"
> 
> nit: I renamed it to $SELINUX_DIR (for consistency with $IMA_DIR)
> and moved to ima_selinux.sh.
okay.

Thanks a lot for your help Petr. Appreciate it.

  -lakshmi
