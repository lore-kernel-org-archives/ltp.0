From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 6 Mar 2020 12:02:06 +0100
Subject: [LTP] [PATCH v2] hugeshmctl01: Small refactor and remove
 stat_time
In-Reply-To: <1583490720-10003-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <20200306071221.GA13530@dell5510>
 <1583490720-10003-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20200306110206.GA14696@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xu,

nice cleanup & refactoring, thanks!

Reviewed-by: Petr Vorel <pvorel@suse.cz>

> @@ -154,6 +155,7 @@ static void stat_setup(void)
>  	}
>  }

> +
nit: this is extra new line (whoever merges this, please remove it).
>  /*
>   * func_stat() - check the functionality of the IPC_STAT command with shmctl()
>   *		 by looking at the pid of the creator, the segement size,

Kind regards,
Petr
