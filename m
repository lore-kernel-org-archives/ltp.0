From: Joerg Vehlow <lkml@jv-coder.de>
Date: Tue, 6 Jul 2021 11:59:17 +0200
Subject: [LTP] [PATCH 0/1] fs_bind: Convert to ltp tests
In-Reply-To: <87wnq37p2j.fsf@suse.de>
References: <20210705135014.679200-1-lkml@jv-coder.de> <87wnq37p2j.fsf@suse.de>
Message-ID: <a4595bcc-15e5-e79a-bd95-143630a33774@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richard,

On 7/6/2021 11:45 AM, Richard Palethorpe wrote:
> Hello Joerg,
>
> Joerg Vehlow <lkml@jv-coder.de> writes:
>
>> Hi everyone,
>>
>> I know this is a huge changeset, but there is not really a good way to
>> break it down into multiple commits. Every step in between would either
>> lead to a broken test suite or a change, that is then changed again.
>> So I made this one huge commit, that converts all of the tests of the
>> testsuite in one go.
> It seems like there are no file renames (according to Git), but many
> files are deleted and created. So you could split the commit into a
> deletion patch and a creation patch.
>
> I guess the deletion patch might have to remove some runtest file
> entries temporarily? However I don't see a big problem with that.
Actually most deletions are renames, that git just did not pick up, 
because of the immense
changes in the tests.
I could add two patches:
1. rename (And delete old testrunner stuff and runtest entries)
2. Apply all changes

This should allow better review of the actual changes, at least for most 
tests.

J?rg
