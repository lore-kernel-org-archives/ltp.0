From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 16 Oct 2019 16:23:08 +0200
Subject: [LTP] [PATCH] lib: tst_taint: Ignore WARN taint flag if already
 set
In-Reply-To: <1535033044.6472706.1571234622819.JavaMail.zimbra@redhat.com>
References: <20191016131506.17193-1-chrubis@suse.cz>
 <bc2f54f1-3be1-cf77-7475-3c08cbd24850@suse.de>
 <1535033044.6472706.1571234622819.JavaMail.zimbra@redhat.com>
Message-ID: <20191016142308.GD19297@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I wonder if there is more specific way for cve-2017-17053 to determine
> error condition. For example by inspecting new messages in dmesg.

We wanted to avoid that because the taint flags looked like a nice and
simple solution...

-- 
Cyril Hrubis
chrubis@suse.cz
