From: Li Wang <liwang@redhat.com>
Date: Mon, 30 Mar 2020 14:35:09 +0800
Subject: [LTP] [PATCH 5/6] lib: Implement SAFE_RUN_CMD() macro (new API
 only)
In-Reply-To: <20200327213924.18816-6-pvorel@suse.cz>
References: <20200327213924.18816-1-pvorel@suse.cz>
 <20200327213924.18816-6-pvorel@suse.cz>
Message-ID: <CAEemH2fusvyGAnDmfFEYqhnsbHwzrT+B3+FFD6bnJGpz3oB-QA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

Thanks for your work on this.

>
> +static inline void safe_run_cmd(const char *file, const int lineno,
> +                                                          const char
> *const argv[],
>

Be cautious of the code indent here, otherwise patchset looks good.


> +                             const char *stdout_path,
> +                             const char *stderr_path)
> +{
>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200330/0fcdfb80/attachment.htm>
