From: Martin Doucha <mdoucha@suse.cz>
Date: Mon, 6 Sep 2021 15:27:00 +0200
Subject: [LTP] [PATCH 4/7] syscalls/kill05: Use any two unprivileged
 users
In-Reply-To: <YTYSMBjdtVayFnOc@yuki>
References: <20210903154848.18705-1-mdoucha@suse.cz>
 <20210903154848.18705-5-mdoucha@suse.cz> <YTYJUPFc75TuOJSb@yuki>
 <77fd98d9-5257-c1da-a01b-77d8cc1b6bce@suse.cz> <YTYOpPM5uupQrayf@yuki>
 <2ce3b46e-b503-a44d-8c16-819e587e217a@suse.cz> <YTYSMBjdtVayFnOc@yuki>
Message-ID: <1bd7a640-363d-6f7e-b221-613688906e09@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 06. 09. 21 15:05, Cyril Hrubis wrote:
> Hi!
>> But setting a non-existent UID/GID on a running process is different
>> because the kernel might try to look up some additional data in the
>> user/group database and block the credentials change if the lookup fails.
> 
> No it will not, kernel does not care and never cared about system users
> and groups, that's purely userspace concept. The login(1) process that
> sets up all the process IDS as well as shell variables.

The man pages give no guarantee that it'll stay that way. I'd rather
play it safe with process credentials. From test setup perspective, it's
still less work than the old lookup of specific usernames.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
