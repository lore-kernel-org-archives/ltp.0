From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 4 Jun 2021 20:15:59 +0200
Subject: [LTP] [RFC] Reduce LICENCE/COPYING files
In-Reply-To: <3F3FDAE9-7190-4046-9438-17D2BE14FCA0@gmail.com>
References: <YLeA8KOphpVg3IDP@pevik> <YLi3XqA3hLh7HWqn@yuki>
 <YLjDnXeWib2KSILF@pevik>
 <CAEemH2dTBbHbh5Vf9EQyYMsvHKs3p4sZvoNyR=uCFM0X5siYtQ@mail.gmail.com>
 <YLn3BQHhZIq5vNId@pevik>
 <3F3FDAE9-7190-4046-9438-17D2BE14FCA0@gmail.com>
Message-ID: <YLpt386rlLDzgfCi@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Unless there???s a real need for consolidating the LICENSE files,
> I???d leave it well enough alone in the source tree and just aggregate
> all of the licenses as an uber license and distribute it with the
> binary packages.

As far as I can tell the cleanup patch removes 22 identical copies of
GPL v2 sprinkled randomly over the tree and keeps only the top level
one, while each of the individual files still retains a copyright and a
seprarate license. As far as I can tell this is harmless.

-- 
Cyril Hrubis
chrubis@suse.cz
