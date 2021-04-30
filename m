From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 30 Apr 2021 10:31:17 +0200
Subject: [LTP] [PATCH v2 2/5] bpf: Add map_array helper functions
In-Reply-To: <20210429150510.21585-3-rpalethorpe@suse.com>
References: <20210429150510.21585-1-rpalethorpe@suse.com>
 <20210429150510.21585-3-rpalethorpe@suse.com>
Message-ID: <YIvAVaPNyunDHxaF@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +long bpf_map_array_get(const int map_fd,
> +		       const uint32_t *const array_indx,
> +		       uint64_t *const array_val)

Wouldn't the API be nicer if we passed just index value and returned the
map value? We do TBROK if something goes wrong anyways, so there is no
point in passing the return value from the bpf() syscall.

-- 
Cyril Hrubis
chrubis@suse.cz
