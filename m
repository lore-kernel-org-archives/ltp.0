From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 5 May 2021 16:57:32 +0200
Subject: [LTP] [PATCH v3 4/4] bpf: Check truncation on 32bit div/mod by
 zero
In-Reply-To: <20210505091623.29121-5-rpalethorpe@suse.com>
References: <20210505091623.29121-1-rpalethorpe@suse.com>
 <20210505091623.29121-5-rpalethorpe@suse.com>
Message-ID: <YJKyXC6y3xzwcDql@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	map_fd = bpf_map_array_create(4);
> +	prog_fd = load_prog();
> +	bpf_run_prog(prog_fd, msg, sizeof(MSG));
> +	SAFE_CLOSE(prog_fd);

I've added *key = 0; here so that the test does not break on invalid map
index on subsequent iterations (-i 2).

And also fixed some spaces mixed between tabs used for indentation and
pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
