From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 22 Nov 2016 10:29:37 +0100
Subject: [LTP] syslog tests are failed.
In-Reply-To: <CAJ5vXcS3s=BqxWNJo8PqWa-des8TREbJKdL4H7HP33Q3p=j6XA@mail.gmail.com>
References: <CAJ5vXcQHixS8UOzeFDQ7TNNHzGN5QhWONhXYT67eWCwitynyyQ@mail.gmail.com>
 <271210984.337776.1479474167503.JavaMail.zimbra@redhat.com>
 <CAJ5vXcS3s=BqxWNJo8PqWa-des8TREbJKdL4H7HP33Q3p=j6XA@mail.gmail.com>
Message-ID: <20161122092936.GC7048@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I have build it using yacto (Poky).

Hmm, have you checked what the service command really does? My guess
would be that it does something completely different in yocto.

-- 
Cyril Hrubis
chrubis@suse.cz
