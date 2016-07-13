From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 13 Jul 2016 15:12:08 +0200
Subject: [LTP] [PATCH] lib: add tst_read_meminfo / tst_get_avail_mem
In-Reply-To: <20160713093505.GA6033@gmail.com>
References: <cad01181438a055f45b32fc28b33a8b8da74b768.1465903335.git.jstancek@redhat.com>
 <CAEemH2fGEGXftvF_HttR18KSbp8YRL_zaMhb38MQ4cpXqr-fMg@mail.gmail.com>
 <1589618283.6491776.1465976075619.JavaMail.zimbra@redhat.com>
 <57614F55.9090407@redhat.com> <20160616052544.GA18852@gmail.com>
 <1809783770.6955910.1466060898915.JavaMail.zimbra@redhat.com>
 <20160713093505.GA6033@gmail.com>
Message-ID: <57863E28.7020309@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 07/13/2016 11:35 AM, Li Wang wrote:
> Jan,
> 
> On Thu, Jun 16, 2016 at 03:08:18AM -0400, Jan Stancek wrote:
>>
>> I'm now considering exposing just a parse function, I'd like to
>> avoid having separate function for each proc file. And possibly
>> more than one since those 2 proc files you mentioned don't have
>> uniform format for all content.
> 
> How is the parse function going?

Latest idea attached.

It's similar to SAFE_FILE_SCANF, but it scanfs each line and first
matching all scanf directives wins and terminates search, otherwise
you get non-zero ret code. For example:

if (SAFE_FILE_LINES_SCANF("/proc/meminfo", "MemFree: %ld", &free))
        tst_brk(TBROK, "Could not parse MemFree");

Regards,
Jan

-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-lib-add-SAFE_FILE_LINES_SCANF.patch
Type: text/x-patch
Size: 5623 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20160713/54918c2b/attachment.bin>
