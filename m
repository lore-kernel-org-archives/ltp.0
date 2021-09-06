From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 6 Sep 2021 14:28:00 +0200
Subject: [LTP] [PATCH 4/7] syscalls/kill05: Use any two unprivileged
 users
In-Reply-To: <20210903154848.18705-5-mdoucha@suse.cz>
References: <20210903154848.18705-1-mdoucha@suse.cz>
 <20210903154848.18705-5-mdoucha@suse.cz>
Message-ID: <YTYJUPFc75TuOJSb@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Usernames such as "bin" may not exist on some systems. Find and use any two
> unprivileged user IDs for the test instead of specific named users.

I do wonder if we have to lookup the UIDs in this case. As long as I
understand the test correctly we are testing that no signals are send to
a process if the sender real of effective UID do not match either of
real and saved set UIDs of the receiving process. If my understanding is
correct we can just take two arbitrary UIDs that != 0 and the test
should work just fine.

-- 
Cyril Hrubis
chrubis@suse.cz
