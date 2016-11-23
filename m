From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 23 Nov 2016 12:02:58 +0100
Subject: [LTP] syslog tests are failed.
In-Reply-To: <CAJ5vXcSyYcArEmadiFDey57-XX-aVhj+pvr+x9feMoPF7jgmvA@mail.gmail.com>
References: <CAJ5vXcQHixS8UOzeFDQ7TNNHzGN5QhWONhXYT67eWCwitynyyQ@mail.gmail.com>
 <271210984.337776.1479474167503.JavaMail.zimbra@redhat.com>
 <CAJ5vXcS3s=BqxWNJo8PqWa-des8TREbJKdL4H7HP33Q3p=j6XA@mail.gmail.com>
 <20161122092936.GC7048@rei.lan>
 <CAJ5vXcSyYcArEmadiFDey57-XX-aVhj+pvr+x9feMoPF7jgmvA@mail.gmail.com>
Message-ID: <20161123110258.GA3346@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I do not have the support of the service command on my system.
> please, let me know if I need to check any other information.

Then the code to restart the daemon should not try it at all.

There is 'if command -v service' check befor the script tries to call
it.

Anyway what init system does yocto have? How do you restart daemon on
it?

-- 
Cyril Hrubis
chrubis@suse.cz
