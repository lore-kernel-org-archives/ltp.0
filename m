From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 25 Nov 2020 14:13:56 +0100
Subject: [LTP] [PATCH] fzsync: skip test when avaliable CPUs less than 2
In-Reply-To: <CAEemH2ctWEp-B1yfB0cfCy6eP0dSwWLxcdsukV45GyF4SEQVmg@mail.gmail.com>
References: <20201125101633.30154-1-liwang@redhat.com> <87eekhof3i.fsf@suse.de>
 <04c4b073-6ad3-836a-7f63-7632a4e6ddb7@suse.cz>
 <CAEemH2ctWEp-B1yfB0cfCy6eP0dSwWLxcdsukV45GyF4SEQVmg@mail.gmail.com>
Message-ID: <20201125131356.GA30149@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> And we can avoid adding this patch to FuzzySync lib, but for af_alg07 2cpus
> is required.
> (maybe go with Cyril's suggest to add .min_cpus)

I would go for that and we can make use of it in getcwd04.c as well.

-- 
Cyril Hrubis
chrubis@suse.cz
