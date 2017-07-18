From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 18 Jul 2017 15:02:46 +0300
Subject: [LTP] [PATCH v2 2/2] clone09: add a test for CLONE_NEWNET flag
In-Reply-To: <20170622150932.GC28231@rei.lan>
References: <1496915851-5222-1-git-send-email-alexey.kodanev@oracle.com>
 <1496915851-5222-2-git-send-email-alexey.kodanev@oracle.com>
 <20170622150932.GC28231@rei.lan>
Message-ID: <5f8350dc-a487-1d16-0a11-34c3238fadcd@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 06/22/2017 06:09 PM, Cyril Hrubis wrote:
> Hi!
>> +static void do_test(void)
>> +{
>> +	int def_val;
>> +
>> +	tst_res(TINFO, "create clone in a new netns with 'CLONE_NEWNET' flag");
>> +
>> +	SAFE_FILE_SCANF(sysctl_path, "%d", &sysctl_net);
>> +	SAFE_FILE_PRINTF(sysctl_path, "%d", sysctl_net + 1);
>> +
>> +	clone_child();
>> +	tst_reap_children();
>> +
>> +	if (sysctl_net_new == (sysctl_net + 1)) {
>> +		tst_res(TFAIL, "sysctl params equal: %s=%d",
>> +			sysctl_path, sysctl_net_new);
>> +	}
>> +
>> +	SAFE_FILE_SCANF(sysctl_path_def, "%d", &def_val);
>> +
>> +	if (sysctl_net_new != def_val) {
>> +		tst_res(TFAIL, "netns param init to non-default value %d",
>> +			sysctl_net_new);
>> +	}
> We should restore the sysctl_path value here, in a case that we are
> looping (the -i or -I options).

Applied with restoring sysctl value in do_test().

Thanks,
Alexey

>
> Otherwise it looks fine.
>

