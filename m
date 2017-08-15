From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 15 Aug 2017 14:57:31 +0200
Subject: [LTP] [PATCH] [RFC] zram01: Fix on ppc64le
In-Reply-To: <226751203.1704912.1502801311592.JavaMail.zimbra@redhat.com>
References: <1485870273-26990-1-git-send-email-chrubis@suse.cz>
 <20170815092326.GA20715@rei.lan>
 <420182872.1608763.1502797492172.JavaMail.zimbra@redhat.com>
 <20170815123801.GD20715@rei.lan>
 <226751203.1704912.1502801311592.JavaMail.zimbra@redhat.com>
Message-ID: <20170815125731.GA30800@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Other than picking a number by ourselves, nothing comes to mind.
> Numbers from mkfs.btrfs error message seem too low, even 2.5x
> larger number still fails:
> 
> # modprobe brd rd_nr=1 rd_size=100000
> # mkfs.btrfs /dev/ram0 
> btrfs-progs v4.9.1
> See http://btrfs.wiki.kernel.org for more information.
> 
> ERROR: not enough free space to allocate chunk

Now that you mention it I remember some patches for mkfs.btrfs that
fixed the minimal FS size computation. So I guess that hardcoding 384MB
would be a bit safer.

-- 
Cyril Hrubis
chrubis@suse.cz
