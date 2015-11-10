From: vichy <vichy.kuo@gmail.com>
Date: Tue, 10 Nov 2015 20:28:23 +0800
Subject: [LTP] how to cross compile linux test project?
In-Reply-To: <20151109125022.GA20990@rei>
References: <CAOVJa8FYtVzST_sEkeWxaEVFCC1FBo_ASgDjncAy50AaYiFGhA@mail.gmail.com>
 <20151022105504.GA7192@rei.suse.cz>
 <CAOVJa8E1YNg5a2ZeTHY_vpDPJkntpXsys9usaHQNYvBAxDWYcg@mail.gmail.com>
 <20151022121307.GB7192@rei.suse.cz>
 <CAOVJa8EfpYnYXriEa9XeDxH=6vwrprqT2FE+qNugyzw4oY6skg@mail.gmail.com>
 <20151109125022.GA20990@rei>
Message-ID: <CAOVJa8ELe1meGYwjBHgyV-332Q0TXJb7=fKoGzgJ0Htbrx3uYg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

hi Cyril

>
> The build system for Open Posix Testsuite is not integrated with the
> rest of the build system. But it shouldn't need anything more than
> setting up right compiler:
>
> $ export CC=arm-buildroot-linux-gnueabi-gcc
> $ make
>
it work, and many appreciate your kind help ^^
