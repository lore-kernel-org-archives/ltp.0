From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 25 Apr 2016 17:04:25 +0200
Subject: [LTP] [PATCH v3 5/5] kernel/syscalls: add new test with 'open()
 +	O_TMPFILE'
In-Reply-To: <1689676802.79541.1461594932412.JavaMail.zimbra@redhat.com>
References: <1454069150-27889-1-git-send-email-alexey.kodanev@oracle.com>
 <1454069150-27889-6-git-send-email-alexey.kodanev@oracle.com>
 <1689676802.79541.1461594932412.JavaMail.zimbra@redhat.com>
Message-ID: <20160425150424.GD20158@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I'm running 4.5 kernel and both open14 and openat03 are failing
> for me. I tried xfs and ext4, both failed.

For me openat03 fails on ext4 and tmpfs as well but open14 works fine on
4.1.13. Which is kind of strange.

-- 
Cyril Hrubis
chrubis@suse.cz
