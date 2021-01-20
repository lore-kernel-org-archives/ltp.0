From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 20 Jan 2021 04:32:59 -0500 (EST)
Subject: [LTP] [PATCH] mlock_8-1,
 munlock_10-1: don't use LONG_MAX as invalid pointer
In-Reply-To: <CAEemH2dj2KGi6dmYoJaxsvvG1wvecbM8GrpBshHh8CTkm7pe+A@mail.gmail.com>
References: <2e51e5453562001b5b6992ccc897d9177e6673ca.1571053661.git.jstancek@redhat.com>
 <CAEemH2dj2KGi6dmYoJaxsvvG1wvecbM8GrpBshHh8CTkm7pe+A@mail.gmail.com>
Message-ID: <1542162728.33692863.1611135179166.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi Jan,
> 
> I propose to reorg this patch with review comments (maybe apply it after
> the new release).
> 
> Any thought?

This has been fixed in kernel by:
  597399d0cb91 ("arm64: tags: Preserve tags for addresses translated via TTBR1")
  d0022c0ef29b ("arm64: memory: Add missing brackets to untagged_addr() macro")

I'd keep the test as is, maybe add comment with above commits as a hint for future.

