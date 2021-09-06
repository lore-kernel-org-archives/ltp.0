From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 6 Sep 2021 14:50:44 +0200
Subject: [LTP] [PATCH 4/7] syscalls/kill05: Use any two unprivileged
 users
In-Reply-To: <77fd98d9-5257-c1da-a01b-77d8cc1b6bce@suse.cz>
References: <20210903154848.18705-1-mdoucha@suse.cz>
 <20210903154848.18705-5-mdoucha@suse.cz> <YTYJUPFc75TuOJSb@yuki>
 <77fd98d9-5257-c1da-a01b-77d8cc1b6bce@suse.cz>
Message-ID: <YTYOpPM5uupQrayf@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > I do wonder if we have to lookup the UIDs in this case. As long as I
> > understand the test correctly we are testing that no signals are send to
> > a process if the sender real of effective UID do not match either of
> > real and saved set UIDs of the receiving process. If my understanding is
> > correct we can just take two arbitrary UIDs that != 0 and the test
> > should work just fine.
> 
> We could just use UID 1 and 2 for this test but I'd rather not assume
> that set*uid() functions allow setting unused UIDs. Even if it works
> now, it could easily break in the future or on some special system auth
> backends.

Don't we already depend on being able to use unused GID? How is this
different?

-- 
Cyril Hrubis
chrubis@suse.cz
