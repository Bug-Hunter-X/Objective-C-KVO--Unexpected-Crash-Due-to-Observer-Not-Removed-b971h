# Objective-C KVO Crash: Observer Removal

This repository demonstrates a subtle bug related to Key-Value Observing (KVO) in Objective-C. The problem occurs when an observer isn't removed before the observed object is deallocated, leading to a crash. 

## The Bug
The `bug.m` file shows a scenario where a KVO observer is added but not removed.  When the observed object is deallocated, attempting to access its properties from within the observer's `observeValueForKeyPath` method causes an EXC_BAD_ACCESS error.

## The Solution
The `bugSolution.m` file provides the corrected code. Before the observed object is released, the observer is removed using `removeObserver:forKeyPath:`.  This prevents the crash by ensuring the observer doesn't access deallocated memory.

## How to Reproduce
1. Clone this repository.
2. Open the project in Xcode.
3. Run the `bug.m` example to see the crash. 
4. Run the `bugSolution.m` example to see the corrected behavior.

## Key takeaway
Always remember to remove KVO observers before the observed object is deallocated to avoid unexpected crashes.