From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 1 Dec 2017 14:23:55 +0100
Subject: [LTP] [PATCH v2] hugetlb: fix warnings in cleanup()
In-Reply-To: <20171201035559.11478-1-liwang@redhat.com>
References: <20171201035559.11478-1-liwang@redhat.com>
Message-ID: <20171201132354.GA30225@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +void save_nr_hugepages(void)
> +{
> +	check_hugepage();
> +	orig_hugepages = get_sys_tune("nr_hugepages");
> +}

I've changed this function to return the orig_hugepages instead of void
so that we can use it in the testcases when needed. Since I find this a
bit cleaner solution than having the library internal variable exported
in header file. Pushed, thanks a lot.

-- 
Cyril Hrubis
chrubis@suse.cz
