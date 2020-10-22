From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 22 Oct 2020 02:01:36 -0400 (EDT)
Subject: [LTP] Broken Fedora build
In-Reply-To: <CAEemH2cAeMzbr6WWDOTTNYkU8b+1J+7WEHjGU283r3qWtXP8TA@mail.gmail.com>
References: <20201021193547.GA49488@x230>
 <CAEemH2cAeMzbr6WWDOTTNYkU8b+1J+7WEHjGU283r3qWtXP8TA@mail.gmail.com>
Message-ID: <493039434.18941934.1603346496769.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Petr Vorel <pvorel@suse.cz> wrote:
> 
> > Fedora build is broken due missing <sys/timeb.h> [1].
> > Quick fix would probably be to use Fedora 33 instead of Rawhide. [2]
> > But we should port hugetlb.c and trace_sched.c (if used) to gettimeofday or
> > clock_gettime. [3]
> 
> +1
> I prefer to go replace ftime() by gettimeofday() or clock_gettime()
> way to solve this from root.

Agreed, ftime is marked as obsolete.

