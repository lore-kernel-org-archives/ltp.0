Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Xtdvh-0005rz-AF
	for ltp-list@lists.sourceforge.net; Wed, 26 Nov 2014 14:50:53 +0000
Date: Wed, 26 Nov 2014 15:50:04 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141126145004.GA3306@rei>
References: <1414035112-28248-1-git-send-email-liwan@redhat.com>
	<20141106102218.GA2179@rei.nue.novell.com>
	<857789373.5490769.1415284744752.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <857789373.5490769.1415284744752.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCH] /vm/hugepage/thp/thp05: cleanup should not use
 safe macros
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Li Wang <liwang@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> > What should be done in this case is to create an equivalent to the
> > SAFE_FILE_PRINTF() function that is not calling the tst_brkm() and
> 
> 
> well, if create a new safe function/macro to replace use the SAFE_FILE_PRINTF
> but not calling tst_brkm(), that's will be break the safe rule.  
> if create a unsafe function/macro, I dont know where is to place the 
> new function and how to rename. 
> 
> Additional, i found so much testcases use safe macro in there cleanup(), that's 
> really a hard work if maintain all.

The ideal solution would be to create a base functions file_scanf() and
file_printf() that would look like safe_file_scanf() and
safe_file_printf() but without the file, lineno and cleanup parameters.

These would return non-zero return value on failure and then we can base the
safe_file_scanf() on the top of these functions.

I.e. safe_file_scanf() would call file_scanf() and call tst_brkm() if
file_scanf() has reported a failure. Then we can use file_scanf() in test
cleanup. But as these functions use variable number of arguments this needs one
more indirection with functions that takes va_list.

int file_vscanf(const char *file, const char *fmt, va_list va)
{
	// do here what safe_file_scanf() does but return with error
        // instead of tst_brkm()
}

int file_scanf(const char *file, const char *fmt, ...)
{
	va_list va;

	va_start(va, fmt);
	ret = file_vscanf(file, fmt, va);
	va_end(va);

	return ret;
}

void safe_file_scanf(const char *file, const int lineno,
                     void (*cleanup_fn) (void),
                     const char *path, const char *fmt, ...)
{
	// call file_vscanf() here and switch on it's exit value
        // i.e. one for failed to open file
        //      one for EOF
        //      one for unexpected number of conversion
        //      and exit cleanly on zero
}

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=157005751&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
