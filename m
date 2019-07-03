From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 3 Jul 2019 15:10:05 +0200
Subject: [LTP] [PATCH RFC] move_pages12: handle errno EBUSY for
 madvise(..., MADV_SOFT_OFFLINE)
In-Reply-To: <20190607095213.13372-1-liwang@redhat.com>
References: <20190607095213.13372-1-liwang@redhat.com>
Message-ID: <20190703131005.GA1712@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +			if (ret == EINVAL) {
>  				SAFE_KILL(cpid, SIGKILL);
>  				SAFE_WAITPID(cpid, &status, 0);
>  				SAFE_MUNMAP(addr, tcases[n].tpages * hpsz);
>  				tst_res(TCONF,
>  					"madvise() didn't support MADV_SOFT_OFFLINE");
>  				return;
> +			} else if (ret == EBUSY) {
> +				SAFE_MUNMAP(addr, tcases[n].tpages * hpsz);
> +				goto out;

Shouldn't we continue with the test here rather than exit?

I guess that there is no harm in doing a few more iterations if we
manage to hit EBUSY, or is there a good reason to exit the test here?

Otherwise the patch looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
