From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 27 Jul 2021 15:09:05 +0200
Subject: [LTP] [PATCH v4,
 2/2] cgroup/cgroup_regression_test: Fix umount failure
In-Reply-To: <62262681-222f-8d09-a100-0d7be0c7526f@jv-coder.de>
References: <20210719092239.GA1475@atcfdc88> <YPgxJwx795fhXgLa@pevik>
 <62262681-222f-8d09-a100-0d7be0c7526f@jv-coder.de>
Message-ID: <YQAFcVwvz+eXGOsk@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I had a first look at this patches and was curious, what the reasoning 
> behind the "/" is.
> The comment you suggest is wrong. The / was introduced to prevent 
> unmounting some other mountpoint,
> where the device was cgroup.
> Imho the approach of adding a / to the end was wrong and intransparent. 
> I would rather use "./cgroup" or "$PWD/cgroup".

Passing full path to the cgroup directory sound much safer to me
especially when the directory name is just 'cgroup', try it yourself:

device=cgroup/; grep "${device%/}" /proc/mounts

On my machine this yields 10 lines and 21 matches.

> If possible, I'd actually change tst_umount, to always unmount the 
> mountpoint and not the device, i.e. if the given path is not an absolute 
> path, make it absolute (e.g. by prepending $PWD").
> This way the check if the mountpoint exist wouldn't be the fuzzy thing 
> it is right now.

Strongly agree here.

I would go even one step further and change the library so that it
rejects anything that does not start with '/'.

-- 
Cyril Hrubis
chrubis@suse.cz
