From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 18 May 2021 17:25:51 +0200
Subject: [LTP] [PATCH] network/lib6/getaddrinfo01: rewrite with the new
 API + use static hostnames
In-Reply-To: <7a5dec7a-ed23-2f62-a02f-75667df75835@bell-sw.com>
References: <20210517085637.16866-1-aleksei.kodanev@bell-sw.com>
 <YKNYkNOqsmhv9kSJ@pevik>
 <7a5dec7a-ed23-2f62-a02f-75667df75835@bell-sw.com>
Message-ID: <YKPcf1zzYPi8hS1k@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> Hi Petr,

> Thank you for review!
Thank you for finding a time to cleanup this, it'd take long time to me to
rewrite it.

> > Moving everything to /etc/hosts based setup is a great idea
> > as we get rid of network setup related failures.

> > Do we lost any getaddrinfo() test coverage for bypassing DNS?

> We may lose some DNS lookups queries because the files almost always
> will be checked first by nss, and I think this is covered by another
> test, dns-stress{01|02} (focus more on the server than the client).

+1, we don't need to worry.

Kind regards,
Petr
