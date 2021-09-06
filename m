From: Martin Doucha <mdoucha@suse.cz>
Date: Mon, 6 Sep 2021 15:01:07 +0200
Subject: [LTP] [PATCH 4/7] syscalls/kill05: Use any two unprivileged
 users
In-Reply-To: <YTYOpPM5uupQrayf@yuki>
References: <20210903154848.18705-1-mdoucha@suse.cz>
 <20210903154848.18705-5-mdoucha@suse.cz> <YTYJUPFc75TuOJSb@yuki>
 <77fd98d9-5257-c1da-a01b-77d8cc1b6bce@suse.cz> <YTYOpPM5uupQrayf@yuki>
Message-ID: <2ce3b46e-b503-a44d-8c16-819e587e217a@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 06. 09. 21 14:50, Cyril Hrubis wrote:
> Hi!
>>> I do wonder if we have to lookup the UIDs in this case. As long as I
>>> understand the test correctly we are testing that no signals are send to
>>> a process if the sender real of effective UID do not match either of
>>> real and saved set UIDs of the receiving process. If my understanding is
>>> correct we can just take two arbitrary UIDs that != 0 and the test
>>> should work just fine.
>>
>> We could just use UID 1 and 2 for this test but I'd rather not assume
>> that set*uid() functions allow setting unused UIDs. Even if it works
>> now, it could easily break in the future or on some special system auth
>> backends.
> 
> Don't we already depend on being able to use unused GID? How is this
> different?

We only set unused user/group IDs on files and directories using
chown(). That's perfectly safe because inode owner is just an arbitrary
number that doesn't need to exist as a real entry in the user/group
database. You can get the same result by creating the files under a
valid owner and then deleting the respective user/group so the system
has to be able to handle that situation.

But setting a non-existent UID/GID on a running process is different
because the kernel might try to look up some additional data in the
user/group database and block the credentials change if the lookup fails.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
