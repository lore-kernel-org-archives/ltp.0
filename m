From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 10 Apr 2017 16:32:39 +0200
Subject: [LTP] [PATCH v3 1/1] syscalls/splice04: add test for splice()
 from pipe to pipe
In-Reply-To: <1491375303-1418-1-git-send-email-bxue@redhat.com>
References: <1491375303-1418-1-git-send-email-bxue@redhat.com>
Message-ID: <20170410143239.GB21811@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static void setup(void);
> +static void cleanup(void);
> +static void pipe_pipe(void);

Also these function prototypes are useless as well.

-- 
Cyril Hrubis
chrubis@suse.cz
