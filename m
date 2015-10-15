From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 15 Oct 2015 14:02:47 +0200
Subject: [LTP] [PATCH v4] mem/hugetlb: shift an empty region to use in
 hugemmap02.c
In-Reply-To: <1444879403-17725-1-git-send-email-liwang@redhat.com>
References: <1444879403-17725-1-git-send-email-liwang@redhat.com>
Message-ID: <20151015120246.GA19100@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  static void help(void);
> +int range_is_mapped(void (*cleanup_fn) (void), unsigned long low, unsigned long high);

I've removed this function prototype (since the same prototype is in the
mem.h header) and pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
