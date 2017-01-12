From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 12 Jan 2017 18:00:22 +0100
Subject: [LTP] [PATCH 4/4] mmapstress03: Fix 32bit test on 64bit kernel
In-Reply-To: <374582327.1951599.1484239285415.JavaMail.zimbra@redhat.com>
References: <1484227419-16955-1-git-send-email-chrubis@suse.cz>
 <1484227419-16955-4-git-send-email-chrubis@suse.cz>
 <1342382447.1910370.1484232088575.JavaMail.zimbra@redhat.com>
 <20170112150550.GA5381@rei.lan>
 <374582327.1951599.1484239285415.JavaMail.zimbra@redhat.com>
Message-ID: <20170112170021.GA29187@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Something as (((uintptr_t)1) << ((sizeof(void*)<<3) - 1) - pagesize)
> 
> Wouldn't this crash same as original?

That does not seem to be the case here I guess that the reason is that
the size passed to the mmap2() in case of the 32bit binary on 64bit
kernel is so close to 4GB after the patch that it's rejected right away
as well. And possibly for 32bit binary on 32bit kernel 2GB size is
enough to be rejected for the very same reason.

-- 
Cyril Hrubis
chrubis@suse.cz
