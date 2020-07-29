From: Erico Nunes <ernunes@redhat.com>
Date: Wed, 29 Jul 2020 12:55:46 +0200
Subject: [LTP] [PATCH v2 1/3] lib: add function to check for kernel
 lockdown
In-Reply-To: <CAEemH2d+EOzF8aKAkpsnUO1GqgPh3J40RBDXyBg0E5NC8nrSuw@mail.gmail.com>
References: <20200728162207.332109-1-ernunes@redhat.com>
 <CAEemH2d+EOzF8aKAkpsnUO1GqgPh3J40RBDXyBg0E5NC8nrSuw@mail.gmail.com>
Message-ID: <678ed5c9-d678-6673-666b-05b999567977@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



On 7/29/20 5:14 AM, Li Wang wrote:
> Thanks Erico for patch V2.
> 
> On Wed, Jul 29, 2020 at 12:23 AM Erico Nunes <ernunes@redhat.com
> <mailto:ernunes@redhat.com>> wrote:
> 
>     Some syscalls are not available if the kernel is booted using the
>     'lockdown' feature. That can cause some tests to report fail, showing
>     a message like:
> 
>     ? Lockdown: iopl01: iopl is restricted; see man kernel_lockdown.7
> 
>     This patch adds a function that can be used by tests to check for this
>     case, so it can be handled accordingly.
> 
>     Signed-off-by: Erico Nunes <ernunes@redhat.com
>     <mailto:ernunes@redhat.com>>
>     ---
>     ...
>     +int tst_lockdown_enabled(void)
>     +{
>     +? ? ? ?char line[BUFSIZ];
>     +? ? ? ?const char *lockdown_path = "/sys/kernel/security/lockdown";
> 
> 
> I prefer to add a macro definition in the header file instead of this ^.
> ? ? #define PATH_LOCKDOWN? "/sys/kernel/security/lockdown"

I'm ok with that, do you want me to submit another version like this or
can you change while applying?

Thank you

Erico

