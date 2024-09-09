# Similarity Relation Search Algorithm

This document describes the process of performing a similarity relation search on a list of strings, highlighting the best way to handle it without repetition, and providing an algorithm to accomplish the task efficiently.

## Problem Statement

Given a list of students details, we want to detect duplicates using a similarity threshold. "Sentences" that are considered duplicates will be grouped together and stored in a dictionary. The algorithm should avoid redundant comparisons and remove processed "sentences" as it proceeds.

## Approach

### Step 1: Initial Setup
- **Input:** A list of strings (the corpus).
- **Output:** A dictionary of duplicate sentences, where each group of similar sentences is stored under a common key.
 
### Step 2: Processing Logic

1. **Take the First String:**
   - Start with the first string from the list.
   
2. **Comparison Against Remaining Strings:**
   - Compare the first string with the remaining strings in the list.
   - Use a **correlation threshold** of `0.5` to determine similarity.

3. **Handling Results:**
   - **If no string** has a correlation greater than `0.5` with the first string:
     - **Pop it out** of the list. This means that the string has no significant duplicates in the list.
   
   - **If a string** has a correlation greater than `0.5` with the first string:
     - Store the first string and its duplicate in a **dictionary**.
     - The first string will be the key, named `dup0` (if it is the first sentence with duplicates), and both the original and similar strings will be stored in a **list** as values.
   
4. **Eliminate Processed Strings:**
   - Once a string has been compared against the rest of the list, and any similar sentences have been identified, **remove** both the string and its duplicates from the list to prevent repeated comparisons.

5. **Repeat the Process:**
   - Repeat steps 1-4 for the remaining strings in the list until all strings have been processed or removed.

### Algorithm Overview


## Example Illustration

Consider the following list of strings:


**Process Flow:**

1. Start with the string `"apple is red"`.
   - Compare it with all remaining strings.
   - `"the apple is green"` has a correlation of `0.7` (which is greater than 0.5), so they are grouped together.
   - Remove both from the list.

2. Next, process `"a banana is yellow"`.
   - `"yellow banana"` has a correlation of `0.6`, so they are grouped together.
   - Remove both from the list.

3. Repeat this until all strings have been processed.

## Key Highlights

- **Correlation Threshold:** Sentences are considered similar if their correlation score exceeds `0.5`.
- **Duplication Dictionary:** Groups of similar sentences are stored in a dictionary with keys like `dup0`, `dup1`, etc.
- **Efficiency:** The algorithm ensures no string is processed more than once by removing processed sentences from the list.

## Conclusion

This algorithm efficiently handles similarity relation search by iterating through the list of strings, grouping similar sentences, and avoiding repetition.
