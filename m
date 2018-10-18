From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 18 Oct 2018 17:02:09 +0200
Subject: [LTP] [PATCH v3 0/4] New Fuzzy Sync library API
In-Reply-To: <20181010140405.24496-1-rpalethorpe@suse.com>
References: <20181010140405.24496-1-rpalethorpe@suse.com>
Message-ID: <20181018150209.GA26947@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've dusted off my old pxa270 PDA and tried to compare the different
implementations of the fuzzy sync library:

|-------------------------------------------------------------|
| test          |  old library  |  new library                |
|-------------------------------------------------------------|
| shmctl05      | timeouts      | timeouts                    |
|-------------------------------------------------------------|
| inotify09     | timeouts      | exits in sampling with WARN |
|-------------------------------------------------------------|
| cve-2017-2671 | kernel crash  | kernel crash                |
|-------------------------------------------------------------|
| cve-2016-7117 | kernel crash  | exits in sampling with WARN |
|-------------------------------------------------------------|
| cve-2014-0196 | timetous      | exits in sampling with WARN |
|-------------------------------------------------------------|

The shmctl05 timeouts because the remap_file_pages is too slow and we
fail to do even one iteration, it's possible that this is because we are
hitting the race as well since this is kernel 3.0.0, but I cannot say
that for sure.

The real problem is that we fail to callibrate because the machine is
too slow and we do not manage to take the minimal amount of samples
until the default timeout.

If I increase the timeout percentage to 0.5, we manage to take at least
minimal amount of samples and to trigger the cve-2016-7117 from time to
time. But it looks like the bias computation does not work reasonably
reliably there, not sure why. But looking at the latest version adding
bias no longer resets the averages, which may be the reason because the
bias seems to be more or less the same as the number minimal samples.

So there are a few things to consider, first one is that the default
timeout percentage could be probably increased so that we do not have to
tune the LTP_TIMEOUT_MUL even on slower processors. The downside is that
these testcase would take longer on modern harware. Maybe we can do some
simple CPU benchmarking to callibrate the timeout.

Second thing to consider is if and how to tune the minimal amount of
samples, Maybe we can set the minimal amount of samples to be smaller
and then exit the callibration if our deviation was small enough three
times in a row. But then there is this bias that we have to take into an
account somehow.

-- 
Cyril Hrubis
chrubis@suse.cz
