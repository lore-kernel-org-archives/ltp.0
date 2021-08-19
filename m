From: Li Wang <liwang@redhat.com>
Date: Thu, 19 Aug 2021 11:45:16 +0800
Subject: [LTP] [PATCH v2 1/1] binfmt_misc02.sh: Use "command -v" instead
 of "which"
In-Reply-To: <20210818100823.1836-1-pvorel@suse.cz>
References: <20210818100823.1836-1-pvorel@suse.cz>
Message-ID: <CAEemH2f_syoR+UDwwrcjqavv=Dm_ojynvQALS-O4HV8nm4fK2g@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Aug 18, 2021 at 6:08 PM Petr Vorel <pvorel@suse.cz> wrote:

> "which" has been discontinued after 2.21 release in 2015 due this (git
> repository is empty [1]) it provides warning on Debian/Ubuntu [2].
>
> Use "command -v" which is POSIX [3] and supported on all common shells
> (bash, zsh, dash, busybox sh, mksh).
>
> [1] https://git.savannah.gnu.org/cgit/which.git
> [2]
> https://salsa.debian.org/debian/debianutils/-/commit/3a8dd10b4502f7bae8fc6973c13ce23fc9da7efb
> [3]
> https://pubs.opengroup.org/onlinepubs/9699919799/utilities/command.html
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
>
Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210819/64900e49/attachment.htm>
