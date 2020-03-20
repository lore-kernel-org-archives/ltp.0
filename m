From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 20 Mar 2020 10:53:12 +0100
Subject: [LTP] [PATCH v4 3/3] Add connection tests for bind()
In-Reply-To: <20200317121057.13529-3-mdoucha@suse.cz>
References: <20200317121057.13529-1-mdoucha@suse.cz>
 <20200317121057.13529-3-mdoucha@suse.cz>
Message-ID: <20200320095312.GC12179@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Martin,

> +	SAFE_LISTEN(listen_sock, 1);
> +	SAFE_PTHREAD_CREATE(&thread_id, NULL, peer_thread, &tc_copy);
> +	sock = accept(listen_sock, (struct sockaddr *)&remote_addr,
> +		&remote_len);
> +
> +	if (sock < 0)
> +		tst_brk(TBROK | TERRNO, "accept() failed");
We can just use 
	sock = SAFE_ACCEPT(listen_sock, (struct sockaddr *)&remote_addr,
 		&remote_len);

Whole patch set looks ok to me.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr
