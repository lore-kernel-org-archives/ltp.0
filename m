From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 28 Aug 2018 12:00:08 +0200
Subject: [LTP] [PATCH] syscalls/move_pages: move_pages() can return
 positive value
In-Reply-To: <15602db6c7187069f12f06cac46d06e1b715bbb9.1535376449.git.jstancek@redhat.com>
References: <15602db6c7187069f12f06cac46d06e1b715bbb9.1535376449.git.jstancek@redhat.com>
Message-ID: <20180828100008.GA14275@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  		ret = numa_move_pages(0, TEST_PAGES, pages, NULL, status, 0);
> -		if (ret != 0) {
> +		if (ret == -1) {

Maybe we should go for (ret < 0) but other than that this looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
