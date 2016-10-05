From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 5 Oct 2016 17:38:56 +0200
Subject: [LTP] [PATCH 2/2] writev: remove old tests for partially
 invalid iovec
In-Reply-To: <aaac8a5d1c04de00152f0ab569d732323ab800ab.1475670993.git.jstancek@redhat.com>
References: <c6be7469f0f59fa5c0d65e9466d0d9686a1251b3.1475670993.git.jstancek@redhat.com>
 <aaac8a5d1c04de00152f0ab569d732323ab800ab.1475670993.git.jstancek@redhat.com>
Message-ID: <20161005153856.GD23476@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> -	/* testcase# 3 */
> +	/* TODO: remove this, partially invalid iovec is tested in writev07 */
>  	{(buf1 + CHUNK * 6), CHUNK},
>  	{(caddr_t) - 1, CHUNK},
>  	{(buf1 + CHUNK * 8), CHUNK},

Maybe it would be better to split this into five struct iovec structures
to avoid the magic constants in the code. Otherwise it's fine.

-- 
Cyril Hrubis
chrubis@suse.cz
