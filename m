From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 6 Oct 2015 14:08:42 +0200
Subject: [LTP] [PATCH] containers/share: added namespaces types argument
 for ns_exec
In-Reply-To: <1443775836-21843-1-git-send-email-mmarhefk@redhat.com>
References: <1443775836-21843-1-git-send-email-mmarhefk@redhat.com>
Message-ID: <20151006120842.GA28743@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/testcases/kernel/containers/share/ns_exec.c b/testcases/kernel/containers/share/ns_exec.c
> index e2f068c..f00b587 100644
> --- a/testcases/kernel/containers/share/ns_exec.c
> +++ b/testcases/kernel/containers/share/ns_exec.c
> @@ -40,6 +40,46 @@ char *TCID = "ns_exec";
>  int ns_fd[NS_TOTAL];
>  int ns_fds;
>  
> +struct param {
> +	const char *name;
> +};
> +
> +struct param params[] = {
> +	{"ipc"},
> +	{"mnt"},
> +	{"net"},
> +	{"pid"},
> +	{"user"},
> +	{"uts"},
> +	{NULL}
> +};
> +
> +
> +struct param *get_param(const char *name)
> +{
> +	int i;
> +
> +	for (i = 0; params[i].name; i++) {
> +		if (!strcasecmp(params[i].name, name))
> +			return params + i;
> +	}
> +
> +	return NULL;
> +}

I would consider sharing this part with ns_create.c. I.e. pulling the
struct param and get_param() function from ns_create.c to some common.h
header and including it in both places so that we don't have to manage
the list of namespaces in two places.

Apart from that the the patch looks good, acked.

-- 
Cyril Hrubis
chrubis@suse.cz
