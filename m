From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 16 Apr 2020 15:52:45 +0200
Subject: [LTP] [PATCH v2] Add test for CVE 2018-9568
In-Reply-To: <20200416122023.20952-1-mdoucha@suse.cz>
References: <20200416122023.20952-1-mdoucha@suse.cz>
Message-ID: <20200416135245.GC15339@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static void cleanup(void)
> +{
> +	if (listenfd >= 0)
> +		SAFE_CLOSE(listenfd);
> +}

I've chnaged this to listenfd > 0, because if the first SAFE_CALL() in
setup has failed we will close stdin here.

Corrected the licence and pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
