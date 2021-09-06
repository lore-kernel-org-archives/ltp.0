From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 6 Sep 2021 15:05:52 +0200
Subject: [LTP] [PATCH 4/7] syscalls/kill05: Use any two unprivileged
 users
In-Reply-To: <2ce3b46e-b503-a44d-8c16-819e587e217a@suse.cz>
References: <20210903154848.18705-1-mdoucha@suse.cz>
 <20210903154848.18705-5-mdoucha@suse.cz> <YTYJUPFc75TuOJSb@yuki>
 <77fd98d9-5257-c1da-a01b-77d8cc1b6bce@suse.cz>
 <YTYOpPM5uupQrayf@yuki>
 <2ce3b46e-b503-a44d-8c16-819e587e217a@suse.cz>
Message-ID: <YTYSMBjdtVayFnOc@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> But setting a non-existent UID/GID on a running process is different
> because the kernel might try to look up some additional data in the
> user/group database and block the credentials change if the lookup fails.

No it will not, kernel does not care and never cared about system users
and groups, that's purely userspace concept. The login(1) process that
sets up all the process IDS as well as shell variables.

-- 
Cyril Hrubis
chrubis@suse.cz
