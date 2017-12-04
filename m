From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 4 Dec 2017 16:33:00 +0100
Subject: [LTP] [PATCH v3] kernel/input: fix failure on an old kernel
In-Reply-To: <1510555504-6103-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20171109134523.GA23734@rei>
 <1510555504-6103-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20171204153300.GA21055@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +			if (sync_event_ignored && check_sync_event(&ev)) {
> +				ret = 0;

I've added a TINFO message here that we ignored the empty sync event
here and pushed, thanks.

> +			} else {
> +				tst_resm(TINFO,
> +					 "Unexpected ev type=%i code=%i value=%i",
> +					 ev.type, ev.code, ev.value);
> +			}
>  		}
>  	}

-- 
Cyril Hrubis
chrubis@suse.cz
