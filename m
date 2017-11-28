From: Sandeep Patil <sspatil@google.com>
Date: Tue, 28 Nov 2017 06:25:18 -0800
Subject: [LTP] [PATCH v2 3/4] mm: mallocstress: use futexes instead of
	SysV semaphores
In-Reply-To: <862867765.42579558.1511181413030.JavaMail.zimbra@redhat.com>
References: <20171114021118.103786-1-sspatil@google.com>
 <20171114021118.103786-4-sspatil@google.com>
 <862867765.42579558.1511181413030.JavaMail.zimbra@redhat.com>
Message-ID: <CAJNQT8EBXg4s7N=DRjUbTZ-aCyFKdSQTLSrssD75UazGi60jLQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Nov 20, 2017 at 4:36 AM, Jan Stancek <jstancek@redhat.com> wrote:

> mallocstress set pushed with following changes:
> - 2/3 patch dropped, replaced with ".needs_checkpoints = 1"
>

Ah, thanks for this. I suspected I was missing something
obvious.

<snip>

- ssp
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20171128/63c7c27a/attachment.html>
