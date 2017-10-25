From: Li Wang <liwang@redhat.com>
Date: Wed, 25 Oct 2017 17:15:04 +0800
Subject: [LTP] [PATCH] ltp: keep the .tid hidden in the test library
In-Reply-To: <20171025090541.GD4244@rei>
References: <20171025081150.11206-1-liwang@redhat.com>
 <CAEemH2ekrPr8OJAwKP4Zog+M1xNCR7wqW-QBt-6AOUiCxbMWPQ@mail.gmail.com>
 <20171025090541.GD4244@rei>
Message-ID: <CAEemH2fVnP3izB2a9h0Z=gbmA_WnfF9KwT6KdBRGPOvTH=+m3Q@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Oct 25, 2017 at 5:05 PM, Cyril Hrubis <chrubis@suse.cz> wrote:
> Hi!
>> Attaching a new patch to achieve the same target in another way. It
>> just remove the .tid from test struct and take use of TCID to replace.
>>
>> Which one do you think is better?
>
> I think that removing it from the test structure is better, but reusing
> the oldlib TCID seems to be a bit messy solution to me. We may get rid
> of that one in the future, if we happen to convert all the oldlib
> testcases. I would be a bit happier if we decleared static char *tid in
> the tst_test.c instead.

Ok, I understand. Thanks for reviewing quickly. Let me drafted a new patch.
