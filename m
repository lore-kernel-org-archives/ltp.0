From: xuyang <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 16 May 2019 18:47:16 +0800
Subject: [LTP] increase quotactl01.c coverage
Message-ID: <5CDD3FB4.50502@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi

Current, most distros enable QFMT_V2([1]) and disable QFMT_V1.  So when we run quotaclt01.c ,it uses quota_v2 (format id 2, /mntpoint/aquota.user,/mointpoint/aquota.group)
But if we enable CONFIG_QFMT_V2 and CONFIG_QFMT_V1 in kernel, the following combinations also take effect and succeed.

1.  format id 1（QFMT_VFS_OLD), /mntpoint/quota.user,/mointpoint/quota.group，using quotacheck -ug --format=vfsold
2.  format id 2（QFMT_VFS_V0), /mntpoint/aquota.user,/mointpoint/aquota.group，using quotacheck -ug --format=vfsv0
3.  format id 4（QFMT_VFS_V1), /mntpoint/aquota.user,/mointpoint/aquota.group，using quotacheck -ug --format=vfsv1

But I don't find a good way to test the above three format in quotaclt01.c . Does anyone have a good way?
By the way, I think ltp-quota.m4 can be rewrite or remove because it is confused. I think we can only check Q_GETINFO and sys/quota.h in ltp-quota.m4.
If someone is interested in this case, you can use this attached patch. 

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/quota/Kconfig



-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: 0001-syscalls-quotactl01.c-add-vfsold-and-vfsv1-format-ch.patch
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190516/505b1015/attachment.ksh>
