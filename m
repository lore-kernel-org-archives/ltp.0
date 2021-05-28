From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 28 May 2021 09:36:20 +0200
Subject: [LTP] [PATCH 1/1] sendfile0{2,9}: Remove OFF_T workaround
In-Reply-To: <20210526104633.29561-1-pvorel@suse.cz>
References: <20210526104633.29561-1-pvorel@suse.cz>
Message-ID: <YLCddN29evt3O5jw@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Using OFF_T definition to off64_t for 64bit variants seems to be am old
> workaround for buggy libc. Nowadays we can rely on off_t to have correct size
> (i.e.: 32bit: 4 bytes; 64bit or 32bit with -D_FILE_OFFSET_BITS=64: 8 bytes)

Looks good to me, Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

> Suggested-by: Cyril Hrubis <chrubis@suse.cz>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> NOTE: -DOFF_T=off64_t is also defined in testcases/kernel/io/disktest
> and mentioned in {tst_,}safe_macros.h.

We should remove the -DOFF_T=off64_t comment from the *safe_macros.h and
keep only the _FILE_OFFSET_BITS there.


-- 
Cyril Hrubis
chrubis@suse.cz
