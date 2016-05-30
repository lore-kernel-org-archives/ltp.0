From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Mon, 30 May 2016 21:28:54 +0200
Subject: [LTP] [LTP-20160510] acl_test01: 44: .: test.sh: not found
In-Reply-To: <20160530153220.GB8207@rei.lan>
References: <CA+icZUWdzSCUCPM_91Rg3vk1LNGQ7iuAWVqxbPRcjs5ijKSFaw@mail.gmail.com>
 <20160530142131.GA7416@rei>
 <CA+icZUWRAiAx6bJKNC=Ci6bjR8+jk61ea+xBLcD1Rchu6u7GYg@mail.gmail.com>
 <20160530151115.GA8207@rei.lan>
 <CA+icZUVDvU2JK8AbPn2hVE8QHRUAxmk0k1QHeFgw+Ncsb2V9FA@mail.gmail.com>
 <20160530153220.GB8207@rei.lan>
Message-ID: <CA+icZUXd0TC36TgYjMDg-6+f-M555C0yu3Pz4R410wutPDNi-A@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

[...]
>> Is there a testcase around - runnable via "runltp -s $testcase_script".
>
> These are executed as a part of syscall tests.
>
> You can simply do ./runltp -s xattr to execute all testcases that have
> xattr in their name.
>

Running xattr testcase has shown a different issue.
In [1] Andreas explains why cgroup_xattr tests fails...

"The test seems to try getting/setting an xattr named "trusted." (no
suffix). That's an invalid name; such invalid names are rejected since
commit 98e9cb571 "vfs: Distinguish between full xattr names and proper
prefixes" (v4.5-rc1).

Could you try removing that from the LTP test and rerun it?"

I followed the advice and the attached diff fixes the problem here.
Xattr testcase runs successfully,

See attached logs for details.

- Sedat -

[1] http://marc.info/?l=linux-fsdevel&m=146463254520809&w=2
-------------- next part --------------
--- ltp-full-20160510.orig/testcases/kernel/controllers/cgroup_xattr/cgroup_xattr.c
+++ ltp-full-20160510/testcases/kernel/controllers/cgroup_xattr/cgroup_xattr.c
@@ -66,7 +66,9 @@ struct tst_key {
 static struct tst_key tkeys[] = {
 	{ .name = "security.",		.good = 1,	},
 	{ .name = "trusted.test",	.good = 1,	},
+#if 0
 	{ .name = "trusted.",		.good = 1,	},
+#endif
 	{ .name = "user.",		.good = 0,	},
 	{ .name = "system.",		.good = 0,	},
 };
-------------- next part --------------
A non-text attachment was scrubbed...
Name: LTP_RUN_ON-2016_05_30-21h_15m_19s.log
Type: application/octet-stream
Size: 959 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20160530/d5e0f9df/attachment-0002.obj>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: xattr.log
Type: application/octet-stream
Size: 163378 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20160530/d5e0f9df/attachment-0003.obj>
