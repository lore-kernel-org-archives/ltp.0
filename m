From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 25 Sep 2017 15:01:58 +0200
Subject: [LTP] [PATCH v4] thp01: Find largest arguments size
In-Reply-To: <20170922092802.10602-1-rpalethorpe@suse.com>
References: <20170922092802.10602-1-rpalethorpe@suse.com>
Message-ID: <20170925130158.GB25748@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  static void cleanup(void)
>  {
> -	free(arg);
> +	if (arg)
> +		free(arg);

free(NULL) is no-op, I've removed this if and pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
