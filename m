From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 14 Feb 2017 14:23:27 +0100
Subject: [LTP] [PATCH 3/4] newlib: Allow SAFE_MACROS to be called from
 cleanup
In-Reply-To: <350522678.4314423.1487078592694.JavaMail.zimbra@redhat.com>
References: <20170214122639.442-1-chrubis@suse.cz>
 <20170214122639.442-3-chrubis@suse.cz>
 <350522678.4314423.1487078592694.JavaMail.zimbra@redhat.com>
Message-ID: <20170214132326.GC27516@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Code is straight-forward, but maybe we should add a sentence or two
> to docs to clarify what happens when you call SAFE_MACRO in cleanup:
> 1) cleanup continues to run and
> 2) TBROK errors are reported as TWARN

Sure, will add that.

-- 
Cyril Hrubis
chrubis@suse.cz
