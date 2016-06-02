From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Thu, 2 Jun 2016 17:58:11 +0300
Subject: [LTP] [RFC] shell wrappers for tst_checkpoint
In-Reply-To: <20160601150345.GA23934@rei.lan>
References: <1464791693-10249-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <20160601150345.GA23934@rei.lan>
Message-ID: <57504983.5010106@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!

On 06/01/2016 06:03 PM, Cyril Hrubis wrote:
> Hi!
>> There is a need to use the tst_checkpoint interface from shell, but
>> we don't have wrappers for it (yet).
>>
>> Patch 1 of the series contains one possible implementation for that,
>> patch 2 - an example of usage in the context of the memcg_functional test case.
>>
>> I'd like to get some feedback from LTP users.
>>
>> My primary concern is about two issues:
>>
>> 1. The new test API for C is cool and takes the responsibility on
>>     maintaining the infrastructure for tst_checkpoint. However, I couldn't find
>>     a way to implement something similar in shell, so I switched back to using
>>     two separate functions for that - TST_CHECKPOINT_SETUP, TST_CHECKPOINT_CLEANUP.
>>
>>     There may be a better way...
>
> Well we can always put the cleanup into the tst_exit() which is executed
> both on clean and unclean exit (tst_brkm). And the setup could be done
> right after the checks for TCID and TST_TOTAL. Both supposedly if
> something as TST_NEEDS_CHECKPOINTS=1 has been set before sourcing
> test.sh.
>
> Also nothing stops us from bringing the shell API closer to what we have
> for C :).
>
> We would have to source the test library script after we had defined all
> the setup() cleanup() and test() functions and after setting the
> corresponding TST_ID=foo, TST_NEEDS_CHECKPOINTS=1, etc. But as far as I
> can tell it seems doable.

Could, you, please, have a look at the attached series. I suppose it 
addresses your proposal. In particular, the changes are:
  * tst_checkpoint_* binaries were moved to testcases/lib/
  * logic from TST_CHECKPOINT_CLEANUP was moved to tst_exit()
  * logic from TST_CHECKPOINT_SETUP was moved right into tst_test.sh 
(now it depends on TST_NEEDS_CHECKPOINTS flag)

Existent test cases should not be affected by this change.

If checkpoints are needed, TST_NEEDS_CHECKPOINTS must be defined before 
'.test.sh'. I think this fact could be documented.

>
> And it would be really cool if we managed to use the shared memory for
> test results as well so that result from child processes (subshells)
> would be propagated automatically as well.

Yes, but may this be addressed sometimes later :)


>
>> 2. What is the best location for the new supplemental binaries (tst_checkpoint_wait,
>> tst_checkpoint_wake)? tools/apicmds/ltpapicmd.c or separate source files in
>> testcases/lib/ (similar to tst_sleep)?
>
> I would go for separate binary in testcases/lib/ rather than adding to
> the ltpapicmd.c which should really be removed at some point in future,
> once there are no users for the binary tst_resm.
>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-shell-wrapper-for-tst_checkpoint.patch
Type: text/x-patch
Size: 4897 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20160602/7b15e917/attachment.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0002-an-example-of-usage.patch
Type: text/x-patch
Size: 4677 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20160602/7b15e917/attachment-0001.bin>
