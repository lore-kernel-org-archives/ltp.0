From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 7 Jan 2020 03:49:52 -0500 (EST)
Subject: [LTP] [PATCH v2] syscalls/userfaultfd01: add hint about
 unprivileged_userfaultfd
In-Reply-To: <CAEemH2djB=2=HD=RQxkABDzFt5ZOZr+iVT3_chahSoZSLhoqqQ@mail.gmail.com>
References: <1576641763-18305-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <CAEemH2eKbbXjonuiKMdHcRda98hJikmGW4=YtWft0-1QAj0oBQ@mail.gmail.com>
 <8a1a9b95-5c42-2176-857a-e3c36fa42b55@cn.fujitsu.com>
 <CAEemH2djB=2=HD=RQxkABDzFt5ZOZr+iVT3_chahSoZSLhoqqQ@mail.gmail.com>
Message-ID: <1571639528.891893.1578386992032.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> 
> After thinking over, to report TCONF is the wise method here because this
> test might run with an unprivileged user and it can not modify the knob
> "vm.unprivileged_userfaultfd".
> 
> Sorry and now I pull back my last comment.
> 
> Reviewed-by: Li Wang <liwang@redhat.com>

Pushed, thanks.

