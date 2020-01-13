From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Mon, 13 Jan 2020 09:31:10 +0800
Subject: [LTP] [PATCH v2 1/3] syscalls/capset02: Cleanup & convert to
 new library
In-Reply-To: <20200110143053.GA23359@rei.lan>
References: <20200109124101.GE31981@rei.lan>
 <1578651702-19486-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20200110143053.GA23359@rei.lan>
Message-ID: <ca5cf759-6cb9-1a96-9901-b37b77e9f0ec@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril
>> +	TEST(prctl(PR_CAPBSET_DROP, CAP_KILL));
>> +	if (TST_RET == -1)
>> +		tst_res(TFAIL | TTERRNO, "drop CAP_KILL failed");
>> +	else
>> +		drop_flag = 1;
> This flag does not seem to be used anywhere. Can't we simply tst_brk()
> here if the call fails?

Since it has used needs_root flag, I think removing this flag is ok(I 
removed it in verify functions, but forgot to remove it in setup).

Best Regards
Yang Xu


